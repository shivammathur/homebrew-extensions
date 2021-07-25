module.exports = async ({github, context, core}) => {
    const { data: { labels: labels } } = await github.pulls.get({
        owner: context.repo.owner,
        repo: context.repo.repo,
        pull_number: context.issue.number
    })
    const label_names = labels.map(label => label.name)
    if (label_names.includes('CI-syntax-only')) {
        console.log('CI-syntax-only label found. Skipping tests job.')
        core.setOutput('syntax-only', 'true')
    } else {
        console.log('No CI-syntax-only label found. Running tests job.')
        core.setOutput('syntax-only', 'false')
    }
    const runners = ["macos-11.0-m1", "macos-11.0", "macos-10.15", "ubuntu-latest"]
    core.setOutput('runners', JSON.stringify(runners))
    if (label_names.includes('CI-no-fail-fast')) {
        console.log('CI-no-fail-fast label found. Continuing tests despite failing matrix builds.')
        core.setOutput('fail-fast', 'false')
    } else {
        console.log('No CI-no-fail-fast label found. Stopping tests on first failing matrix build.')
        core.setOutput('fail-fast', 'true')
    }
    if (label_names.includes('CI-long-timeout')) {
        console.log('CI-long-timeout label found. Setting long GitHub Actions timeout.')
        core.setOutput('timeout-minutes', '4320')
    } else {
        console.log('No CI-long-timeout label found. Setting short GitHub Actions timeout.')
        core.setOutput('timeout-minutes', '180')
    }
    core.setOutput('container', 'homebrew/ubuntu20.04:latest')
    const test_bot_formulae_args = ["--only-formulae", "--junit", "--only-json-tab", "--skip-dependents"]
    test_bot_formulae_args.push('--root-url="https://ghcr.io/v2/shivammathur/extensions"')
    test_bot_formulae_args.push('--testing-formulae=${{needs.tap_syntax.outputs.testing_formulae}}')
    test_bot_formulae_args.push('--added-formulae=${{needs.tap_syntax.outputs.added_formulae}}')
    test_bot_formulae_args.push('--deleted-formulae=${{needs.tap_syntax.outputs.deleted_formulae}}')
    const test_bot_dependents_args = ["--only-formulae-dependents", "--junit"]
    test_bot_dependents_args.push('--testing-formulae=${{needs.tap_syntax.outputs.testing_formulae}}')
    if (label_names.includes('CI-force-arm')) {
        console.log('CI-force-arm label found. Not passing --skip-unbottled-arm to brew test-bot.')
    } else {
        console.log('No CI-force-arm label found. Passing --skip-unbottled-arm to brew test-bot.')
        test_bot_formulae_args.push('--skip-unbottled-arm')
    }
    if (label_names.includes('CI-force-linux')) {
        console.log('CI-force-linux label found. Not passing --skip-unbottled-linux to brew test-bot.')
    } else {
        console.log('No CI-force-linux label found. Passing --skip-unbottled-linux to brew test-bot.')
        test_bot_formulae_args.push('--skip-unbottled-linux')
    }
    if (label_names.includes('CI-test-bot-fail-fast')) {
        console.log('CI-test-bot-fail-fast label found. Passing --fail-fast to brew test-bot.')
        test_bot_formulae_args.push('--fail-fast')
        test_bot_dependents_args.push('--fail-fast')
    } else {
        console.log('No CI-test-bot-fail-fast label found. Not passing --fail-fast to brew test-bot.')
    }
    if (label_names.includes('CI-skip-dependents')) {
        console.log('CI-skip-dependents label found. Passing --skip-dependents to brew test-bot.')
        test_bot_formulae_args.push('--skip-dependents')
    } else {
        console.log('No CI-skip-dependents label found. Not passing --skip-dependents to brew test-bot.')
    }
    if (label_names.includes('CI-build-dependents-from-source')) {
        console.log('CI-build-dependents-from-source label found. Passing --build-dependents-from-source to brew test-bot.')
        test_bot_dependents_args.push('--build-dependents-from-source')
    } else {
        console.log('No CI-build-dependents-from-source label found. Not passing --build-dependents-from-source to brew test-bot.')
    }
    if (label_names.includes('CI-skip-recursive-dependents')) {
        console.log('CI-skip-recursive-dependents label found. Passing --skip-recursive-dependents to brew test-bot.')
        test_bot_dependents_args.push('--skip-recursive-dependents')
    } else {
        console.log('No CI-skip-recursive-dependents label found. Not passing --skip-recursive-dependents to brew test-bot.')
    }
    core.setOutput('test-bot-formulae-args', test_bot_formulae_args.join(" "))
    core.setOutput('test-bot-dependents-args', test_bot_dependents_args.join(" "))
}