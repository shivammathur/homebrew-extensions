# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for OpenTelemetry Extension
class OpentelemetryAT80 < AbstractPhpExtension
  init
  desc "OpenTelemetry PHP extension"
  homepage "https://github.com/open-telemetry/opentelemetry-php-instrumentation"
  url "https://pecl.php.net/get/opentelemetry-1.1.2.tgz"
  sha256 "43000b9b95d1c10a072a4dce631628dbd8e48af5cac6cd6cbe3b0649ed5fd2d6"
  head "https://github.com/open-telemetry/opentelemetry-php-instrumentation.git", branch: "main"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/opentelemetry/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "6b7f8113a80563aa4557157c20f1271ceb8690fc48f0aeef57ec828202476051"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "440461d27d18a9a42b6fec261869fead944b09d445ebb61c40190c82902b17b9"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "6bf64197bbbbbcda2b5b4ecbd477c20a82047f09daa4fd3b2c178439fdf6dc22"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "1b5d87067ab1ccacf5522e0971cde4c4be39756964d6694352abdf8b609dea53"
    sha256 cellar: :any_skip_relocation, ventura:        "c9d2ec768af474b2f7679457fd26bdbbaf9183b5aee81f3bf206f4725114b5c7"
    sha256 cellar: :any_skip_relocation, monterey:       "1067daa2da81a0935b473a2093c52e9da80f4b390c8e45503494322504c25a68"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a6cbd5c122aaac78e10ba4e91877d0f79448e2b1908c7d89855ac7b5ba7cfba2"
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
