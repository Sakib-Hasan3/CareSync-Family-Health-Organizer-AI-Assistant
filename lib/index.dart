import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class IndexPage extends StatelessWidget {
  const IndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: const _LandingBody(),
    );
  }
}

class _LandingBody extends StatelessWidget {
  const _LandingBody();

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isNarrow = w < 900;

    return Column(
      children: [
        const _TopNav(),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const _HeroSection(),
                const SizedBox(height: 36),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1200),
                    child: Column(
                      children: const [
                        _SectionHeader(
                          title: 'Comprehensive Family Healthcare',
                          subtitle:
                              'Everything your family needs for optimal health and wellness, all in one place.',
                        ),
                        SizedBox(height: 20),
                        _FeaturesGrid(),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                const _Footer(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _TopNav extends StatelessWidget {
  const _TopNav();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isNarrow = MediaQuery.of(context).size.width < 900;

    return Material(
      elevation: 0,
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          border: Border(
            bottom: BorderSide(color: theme.colorScheme.outlineVariant),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: SizedBox(
              height: 64,
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withOpacity(.12),
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Icon(Icons.favorite, color: theme.colorScheme.primary),
                  ),
                  const SizedBox(width: 10),
                  Text('Family Health Org',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      )),
                  const Spacer(),
                  if (!isNarrow) ...[
                    TextButton(onPressed: () {}, child: const Text('Services')),
                    TextButton(onPressed: () {}, child: const Text('About')),
                    TextButton(onPressed: () {}, child: const Text('Contact')),
                    const SizedBox(width: 12),
                  ],
                  OutlinedButton(
                    onPressed: () => context.go('/login'),
                    child: const Text('Sign In'),
                  ),
                  const SizedBox(width: 8),
                  FilledButton(
                    onPressed: () => context.go('/register'),
                    child: const Text('Get Started'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _HeroSection extends StatelessWidget {
  const _HeroSection();

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isNarrow = w < 1000;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF18A3A6), Color(0xFF1FC6A6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: isNarrow
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      _HeroText(),
                      SizedBox(height: 20),
                      _HeroImage(),
                    ],
                  )
                : const Row(
                    children: [
                      Expanded(child: _HeroText()),
                      SizedBox(width: 24),
                      Expanded(child: _HeroImage()),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

class _HeroText extends StatelessWidget {
  const _HeroText();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Your Family's\nHealth Journey\nStarts Here",
          style: theme.textTheme.displaySmall?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            height: 1.1,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          "Comprehensive healthcare solutions for every member of your family.\n"
          "From preventive care to specialized treatments, we're here for you.",
          style: theme.textTheme.bodyLarge?.copyWith(
            color: Colors.white.withOpacity(.92),
          ),
        ),
        const SizedBox(height: 18),
        Wrap(
          spacing: 10,
          runSpacing: 8,
          children: [
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Theme.of(context).colorScheme.primary,
              ),
              onPressed: () => context.go('/register'),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [Text('Join Our Family'), SizedBox(width: 6), Icon(Icons.arrow_forward, size: 18)],
              ),
            ),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                side: const BorderSide(color: Colors.white70),
              ),
              onPressed: () {},
              child: const Text('Learn More'),
            ),
          ],
        ),
      ],
    );
  }
}

class _HeroImage extends StatelessWidget {
  const _HeroImage();

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 16, offset: Offset(0, 10))],
          image: const DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
              'https://images.unsplash.com/photo-1551198291-088ec5d43e86?q=80&w=1600&auto=format&fit=crop',
            ),
          ),
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  const _SectionHeader({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 8),
      child: Column(
        children: [
          Text(title,
              textAlign: TextAlign.center,
              style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800)),
          const SizedBox(height: 6),
          Text(subtitle,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              )),
        ],
      ),
    );
  }
}

class _FeaturesGrid extends StatelessWidget {
  const _FeaturesGrid();

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final columns = w < 700 ? 1 : w < 1100 ? 2 : 3;

    final items = const <_FeatureCardData>[
      _FeatureCardData(
        icon: Icons.favorite_border,
        title: 'Preventive Care',
        text:
            'Regular check-ups and screenings to keep your family healthy and catch issues early.',
      ),
      _FeatureCardData(
        icon: Icons.local_hospital_outlined,
        title: 'Emergency Services',
        text: '24/7 emergency care with experienced medical professionals.',
      ),
      _FeatureCardData(
        icon: Icons.groups_2_outlined,
        title: 'Family Programs',
        text: 'Wellness education and monitoring tailored for families.',
      ),
      _FeatureCardData(
        icon: Icons.access_time,
        title: 'Convenient Hours',
        text: 'Flexible scheduling with evenings and weekends.',
      ),
      _FeatureCardData(
        icon: Icons.devices_outlined,
        title: 'Digital Health Portal',
        text: 'Access records, schedule visits, and message your care team.',
        ctaText: 'Create Your Account',
      ),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 1.7,
      ),
      itemCount: items.length,
      itemBuilder: (context, i) => _FeatureCard(data: items[i]),
    );
  }
}

class _FeatureCardData {
  final IconData icon;
  final String title;
  final String text;
  final String? ctaText;
  const _FeatureCardData({
    required this.icon,
    required this.title,
    required this.text,
    this.ctaText,
  });
}

class _FeatureCard extends StatelessWidget {
  final _FeatureCardData data;
  const _FeatureCard({required this.data});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 0,
      color: theme.colorScheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: theme.colorScheme.outlineVariant),
          borderRadius: BorderRadius.circular(14),
        ),
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: theme.colorScheme.primary.withOpacity(.12),
              child: Icon(data.icon, color: theme.colorScheme.primary, size: 20),
            ),
            const SizedBox(height: 10),
            Text(data.title,
                style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
            const SizedBox(height: 6),
            Expanded(
              child: Text(
                data.text,
                style: theme.textTheme.bodySmall
                    ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
              ),
            ),
            if (data.ctaText != null) ...[
              const SizedBox(height: 10),
              FilledButton.tonal(
                onPressed: () => context.go('/register'),
                child: Text(data.ctaText!),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      color: theme.colorScheme.surface,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Row(
            children: [
              Text('© ${DateTime.now().year} Family Health Org',
                  style: theme.textTheme.bodySmall),
              const Spacer(),
              TextButton(onPressed: () {}, child: const Text('Privacy')),
              TextButton(onPressed: () {}, child: const Text('Terms')),
            ],
          ),
        ),
      ),
    );
  }
}
