# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for OpenTelemetry Extension
class OpentelemetryAT83 < AbstractPhpExtension
  init
  desc "OpenTelemetry PHP extension"
  homepage "https://github.com/open-telemetry/opentelemetry-php-instrumentation"
  url "https://pecl.php.net/get/opentelemetry-1.5.0.tgz"
  sha256 "796676e071b2c6502c4dbdacccd1a2b29e12bf81d5d514b7ba85ce37de232073"
  head "https://github.com/open-telemetry/opentelemetry-php-instrumentation.git", branch: "main"

  livecheck do
    url "https://pecl.php.net/rest/r/opentelemetry/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "8ac001e3d06d71ee143928caa09b9430bffe75767b985bd62b9d2421cfbc8d32"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "c5db67ff33447c7b74a0ac30a693cca233cb114365e8ba9456c5d882d6af6aee"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "2642027f118efc234a6567d4228f36daa00c0251c0d45720b59534e0816df0f7"
    sha256 cellar: :any,                 arm64_linux:       "7f0c27a0cdf62be31d9a5368a27c77b37c6dca1757f439a3c41ce7bb3d7281ef"
    sha256 cellar: :any,                 x86_64_linux:      "195a25d402718a1ea064075e6e5a04048c7d765e4a1e3d9304f6d98ca9216c1e"
  end

  def install
    Dir.chdir "opentelemetry-#{version}"
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
