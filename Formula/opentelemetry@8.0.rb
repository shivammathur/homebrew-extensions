# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for OpenTelemetry Extension
class OpentelemetryAT80 < AbstractPhpExtension
  init
  desc "OpenTelemetry PHP extension"
  homepage "https://github.com/open-telemetry/opentelemetry-php-instrumentation"
  url "https://pecl.php.net/get/opentelemetry-1.5.0.tgz"
  sha256 "796676e071b2c6502c4dbdacccd1a2b29e12bf81d5d514b7ba85ce37de232073"
  head "https://github.com/open-telemetry/opentelemetry-php-instrumentation.git", branch: "main"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/opentelemetry/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "660fbf397af40190f16e3e8b38aef12876ec8be0ac2348e3a10a059c7d71a7de"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "ca33698ab5e36c545c9294aa0967916ec5a435018adf0cc2b7772b85b450ba82"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "f16f7e3368bbaf03c27e14a4176239fe2629a994b426e04687bfab4e7f115e8b"
    sha256 cellar: :any,                 arm64_linux:       "5ee0cf741acce036fb4fa3918907962b17f134a54f5bf2c7739c041ec2eed06f"
    sha256 cellar: :any,                 x86_64_linux:      "09899a821566afa1d8f7679b1a1cb113a772a8826ef60288666d5060d2be57f3"
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
