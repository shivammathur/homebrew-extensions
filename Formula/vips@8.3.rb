# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vips Extension
class VipsAT83 < AbstractPhpExtension
  init
  desc "Vips PHP extension"
  homepage "https://github.com/libvips/php-vips-ext"
  url "https://pecl.php.net/get/vips-1.0.13.tgz"
  sha256 "4e655843e5ee8150c927c10853dfa0d2a3b924bc2453ed8fb5e5a2a90e686f8f"
  revision 2
  head "https://github.com/libvips/php-vips-ext.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/vips/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "8024d7c4e93bff4f626b3f5086133194eb66b677332a1ecad2c5d04b1d0396e5"
    sha256 cellar: :any, arm64_sequoia: "c138a01bcaac927b166d230877550f1af50ece81d15b63fe584033b7f86a9b8a"
    sha256 cellar: :any, arm64_sonoma:  "a8986e428ebe8c6e8c0b6fc620fa2459cf478099be7ecf0448e09b9828800394"
    sha256 cellar: :any, sonoma:        "0ad0ef0e02a52a66ec4184103b9b56238d846e138ebfe2b655384c54a2fee936"
    sha256 cellar: :any, arm64_linux:   "f7a3af365dc01dfc4419f58b0106f79a1fc3557b5ffc967e6e946f6f5df93aaa"
    sha256 cellar: :any, x86_64_linux:  "0f525ce1d054a0a70b9edfe8e31621b931ca34d4de2aadd75d787a6a2acf12b4"
  end

  depends_on "gettext"
  depends_on "glib"
  depends_on "vips"

  def install
    args = %W[
      --with-vips=#{Utils::Path.formula_opt_prefix("vips")}
    ]
    Dir.chdir "vips-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
