# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for OpenTelemetry Extension
class OpentelemetryAT84 < AbstractPhpExtension
  init
  desc "OpenTelemetry PHP extension"
  homepage "https://github.com/open-telemetry/opentelemetry-php-instrumentation"
  url "https://pecl.php.net/get/opentelemetry-1.0.0.tgz"
  sha256 "c986887f3d97568e9457cdeae41f4b4c1ed92b340b7533ecf65945eb7e291f74"
  head "https://github.com/open-telemetry/opentelemetry-php-instrumentation.git", branch: "main"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "77aab42017df3cfa0e0431f5bad781b4195c00ecf067094c8f186c10e5abb31a"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "a991e99949f4d7ee36f3fd3101fd0ee6d6619c44a7111176be4e6c47e171b21a"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "eeec9c3a1cdb7ba2a6cf6498e0753392a4621132aa2c7c1d613b10826352dec1"
    sha256 cellar: :any_skip_relocation, ventura:        "6e4d075f401658577b56dc79e1329333b61f8707a82573735eaf300c9c0109d8"
    sha256 cellar: :any_skip_relocation, monterey:       "56f177eabd46bf0e811f9b4fd5c512e44f60aeedd715169ad067eee20ac26e28"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "e8299323b8d7f125eff629c44cb80060d2e0e12b168e3c9c02775523592f4f09"
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
