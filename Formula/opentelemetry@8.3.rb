# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for OpenTelemetry Extension
class OpentelemetryAT83 < AbstractPhpExtension
  init
  desc "OpenTelemetry PHP extension"
  homepage "https://github.com/open-telemetry/opentelemetry-php-instrumentation"
  url "https://pecl.php.net/get/opentelemetry-1.4.1.tgz"
  sha256 "981edebd3d01b942a7863af097316d725922467699b16d0a70ccf56f37c14a04"
  head "https://github.com/open-telemetry/opentelemetry-php-instrumentation.git", branch: "main"

  livecheck do
    url "https://pecl.php.net/rest/r/opentelemetry/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "bbd6c46d96cd4869b6c9c08bb196343cc69d7c171f2c19f8d8f9aa3497885563"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "95b19d757d9506a7b37c595ae5c79a4aff30171a31e2b01d17784f8fc3778bba"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "3d848315f5299cafd406ac87dc42416dd3657385d9ec37f59c2e25ad8973265e"
    sha256 cellar: :any,                 arm64_linux:   "0d204ff1f9b14f3a982040bf574fff6e88a04fa9f33dbca9adc655ffbc4b5954"
    sha256 cellar: :any,                 x86_64_linux:  "3d029368a45e3089a366158a3e4e368e5f39a1fbdc3ec794ed375000af3bf931"
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
