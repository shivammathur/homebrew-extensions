# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vips Extension
class VipsAT73 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_tahoe:   "6a442a4f25f0305ba270523c5d7a85062944862d140ac1df914766f65193f146"
    sha256 cellar: :any, arm64_sequoia: "1531d2d89d87694ee1cd77141fab1d8026bae108d17da394ef54a83b8233eafc"
    sha256 cellar: :any, arm64_sonoma:  "d16623477440c7d3f5feab5e5c74da78e86b7b76f153d3cecafab9913cf3bf40"
    sha256 cellar: :any, sonoma:        "74e6eefe52561d9bb401c832c2d1abc2c69808bbc4b0f7f70a3242382aa1b046"
    sha256 cellar: :any, arm64_linux:   "e76ee89750ffab1d6cd74694aa548199cd2b338ec891adf3bc6bd0ad1785c3be"
    sha256 cellar: :any, x86_64_linux:  "fcbf9f455441fb34f1de840c759089d5e48238076b91416b0eb1c68e7dc576b4"
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
