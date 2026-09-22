# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for OpenTelemetry Extension
class OpentelemetryAT85 < AbstractPhpExtension
  init
  desc "OpenTelemetry PHP extension"
  homepage "https://github.com/open-telemetry/opentelemetry-php-instrumentation"
  url "https://pecl.php.net/get/opentelemetry-1.4.2.tgz"
  sha256 "a355329259f373c5c7327e66310481726cfabac50cb5483eba000bec791d5017"
  head "https://github.com/open-telemetry/opentelemetry-php-instrumentation.git", branch: "main"

  livecheck do
    url "https://pecl.php.net/rest/r/opentelemetry/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "f737905785abfad19e3b61b04493306db6b78743e2ee5b47d175050f34a7e9d9"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "e53036aee50d2ab17323b385bfa3f9b899047fb57c9096e0a9ccfb9634fc5de8"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "7ce6433fbc0f18716ee860f5fd727138363cbfe89acf1e2db7db8e4e471788f0"
    sha256 cellar: :any,                 arm64_linux:       "7547d49ff782ca9c7c5cd3a745a3dd924c9be79a59e48877a4eaf5ab9b468e60"
    sha256 cellar: :any,                 x86_64_linux:      "4e4c92c5f7a8da7a49d35e41f1a3c79053470f88c21b6fc20c3fa0ef5e9c5c51"
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
