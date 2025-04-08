# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gnupg Extension
class GnupgAT84 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "6bee6944c34814e3416c16faa3870adf7ab4453d056e15d227d961544078aa3a"
    sha256 cellar: :any,                 arm64_sonoma:  "84351080c259d20eb0c74730718a4d59c14e831ef391a73646c7f614c7aac434"
    sha256 cellar: :any,                 arm64_ventura: "3561feca230a317e5a2db03efd009792b5d79ca1ab0d410049d14d4ae5b86434"
    sha256 cellar: :any,                 ventura:       "a909954fbc07afe337f489c5f0eac38eabb924abc7d295d291e36fa87b4b250b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b5620bd549db4f4c92e9e900aebc5673ab4ed0f4fe789a785bd76251955966c6"
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
