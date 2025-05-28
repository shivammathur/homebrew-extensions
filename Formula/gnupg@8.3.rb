# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gnupg Extension
class GnupgAT83 < AbstractPhpExtension
  init
  desc "Gnupg PHP extension"
  homepage "https://github.com/php-gnupg/php-gnupg"
  url "https://pecl.php.net/get/gnupg-1.5.2.tgz"
  sha256 "ad57aa23b3aef550fa4deddd003ff5322b886d55a67d1b020f5682ab829809fd"
  head "https://github.com/php-gnupg/php-gnupg.git", branch: "master"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/gnupg/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "4dbfab180a82fafb30f13a24dd50171f82e480d0d59c6f78d6486f94b0f1deda"
    sha256 cellar: :any,                 arm64_sonoma:  "b76b2197b178e2d0c1ff6d077a764059b7a2271b7d8a1be9d262d1d4ccfb3820"
    sha256 cellar: :any,                 arm64_ventura: "bdf8b9e6dd94a56fe064c7de37009342c31a59f7164e4ff39a673afb97c2e8dd"
    sha256 cellar: :any,                 ventura:       "54aecff3fcb53ae161aa669cf8850d8e6052e70b1810f76d719aa78e5438774e"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "c645a3fe16a835e09552acb4c50a9e1a33f95e6482cdca207514093d93853676"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b100ad53345f48c03dc99cf85676f555932de356bdf64dcf04a8492f0e441402"
  end

  depends_on "gpgme"

  def install
    args = %W[
      --with-gnupg=#{Formula["gpgme"].opt_prefix}
    ]
    Dir.chdir "gnupg-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
