# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT56 < AbstractPhpExtension
  init
  desc "Imagick PHP extension"
  homepage "https://github.com/Imagick/imagick"
  url "https://pecl.php.net/get/imagick-3.7.0.tgz"
  sha256 "5a364354109029d224bcbb2e82e15b248be9b641227f45e63425c06531792d3e"
  head "https://github.com/Imagick/imagick.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 4
    sha256 cellar: :any,                 arm64_monterey: "73878c55e550e6f962da46abb2b40449e0c19e1cb12047ab7eb7910df8558809"
    sha256 cellar: :any,                 arm64_big_sur:  "73512fcb0a46d58609af8f3fb7900d7714c0fbe3ede453f2fd4e2005de64b688"
    sha256 cellar: :any,                 monterey:       "b1b179fb31fe0af3fa760f3085219ad1304f93694a4a2e815e162c8e8f32fd0f"
    sha256 cellar: :any,                 big_sur:        "2b52c041f6da88b4cfa722ed0f0f9042778ab00e8af9ee812eb707a1a62301be"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "42a4ddb3314b6a57178cba6dd8626de598d4babe6ca7b648d888c2c4d81e95eb"
  end

  depends_on "imagemagick"

  def install
    Dir.chdir "imagick-#{version}"
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
