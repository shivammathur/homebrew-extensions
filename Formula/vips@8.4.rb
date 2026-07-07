# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vips Extension
class VipsAT84 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_tahoe:   "6855760ac1836c4c42f49ac21bcfefbb4528a0307bd9ce5338b4dcac1f448e08"
    sha256 cellar: :any, arm64_sequoia: "47de1f3d2bf9805d4ad8d15de62f387420c19d189c1dbaf3790e01ca290ace35"
    sha256 cellar: :any, arm64_sonoma:  "528225e2ee1b226547e2b22d39cacc9e4d0bd106ec040c501e77b753b37417a4"
    sha256 cellar: :any, sonoma:        "afdda61f3d8babac738216943e4211e5e14e47321a7053f71746b532063793f5"
    sha256 cellar: :any, arm64_linux:   "9268ddc2afe29c1ac6c15ffcca0e6fe41b757a5f1da7b9d3c6a09931d120f665"
    sha256 cellar: :any, x86_64_linux:  "dec3a18a4addab58c5775557cd36a26d52ac5e6cc3fac13805dc6f8197ce5cca"
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
