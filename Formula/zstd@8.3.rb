# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT83 < AbstractPhpExtension
  init
  desc "Zstd Extension for PHP"
  homepage "https://github.com/kjdev/php-ext-zstd"
  url "https://pecl.php.net/get/zstd-0.14.0.tgz"
  sha256 "207a87de60e3a9eb7993d2fc1a2ce88f854330ef29d210f552a60eb4cf3db79c"
  head "https://github.com/kjdev/php-ext-zstd.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/zstd/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "0912aa925f2332460f7b7f27acfe318ce72be45e000674dcf0951ce931e625be"
    sha256 cellar: :any,                 arm64_sonoma:  "b6647ade875fe2b31c7c3da30bc4182315cc0448372e0c425d293113d1afb0d6"
    sha256 cellar: :any,                 arm64_ventura: "1762119b6e9e45674b1f9ad20458847d22e3e699fbbfee4186ae4d6a112d6da4"
    sha256 cellar: :any,                 ventura:       "fefb8aa4c61f1325d6761e816969a2f09378539f32862b25e875d6476c586699"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "557d0bcf64a4974a06daaccbac9f2661ba9733da767916cb99fd85b86de66a87"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "27b2a916df269bf2f0490966739f30daac8954fa6a687d034c4df4c15b6abc3c"
  end

  depends_on "zstd"

  def install
    Dir.chdir "zstd-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", "--with-libzstd", phpconfig
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
