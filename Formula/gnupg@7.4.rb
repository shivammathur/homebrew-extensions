# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gnupg Extension
class GnupgAT74 < AbstractPhpExtension
  init
  desc "Gnupg PHP extension"
  homepage "https://github.com/php-gnupg/php-gnupg"
  url "https://pecl.php.net/get/gnupg-1.5.2.tgz"
  sha256 "ad57aa23b3aef550fa4deddd003ff5322b886d55a67d1b020f5682ab829809fd"
  head "https://github.com/php-gnupg/php-gnupg.git"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/gnupg/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "fac9e86c632dbd165b8a3101c1477f7b8e89fcd240839d466b6b7ee17a0011c2"
    sha256 cellar: :any,                 arm64_sonoma:  "139ec107fcd3c28b21827e30e26894729541ca5e921795441bf67b729d5cb658"
    sha256 cellar: :any,                 arm64_ventura: "ac1275faf6a8a7a7c9828f8ee818ca6be3c20d35740f641e45bfff23e1f29555"
    sha256 cellar: :any,                 ventura:       "5c60971008ae23d8acb49f353b63fd32306b7b41170f9068ef5868ea53d3e59d"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "13228b0166815e07bfc3990ea4570fe7bea7f8b5c0d01cdf22b046d73da1e0c5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "799a26ecab98f3ac890f5cae24956318a357d20ab940d77fbde9dc21e1a89176"
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
