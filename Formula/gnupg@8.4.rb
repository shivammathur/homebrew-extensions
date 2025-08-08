# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gnupg Extension
class GnupgAT84 < AbstractPhpExtension
  init
  desc "Gnupg PHP extension"
  homepage "https://github.com/php-gnupg/php-gnupg"
  url "https://pecl.php.net/get/gnupg-1.5.4.tgz"
  sha256 "4d4a0980759bf259e4129ef02cb592bbeb103b4005e7b4bb6945d79488951a50"
  head "https://github.com/php-gnupg/php-gnupg.git", branch: "master"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/gnupg/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "61301e184edc323e527b7af77d315ad0a2264d8242b6f423b09c2192d7888855"
    sha256 cellar: :any,                 arm64_sonoma:  "3d77e80916be117bb7017e4e85066d6f2c16964c205d46f0559cc88c32a1107a"
    sha256 cellar: :any,                 arm64_ventura: "89f007f97b0564fa3843320016c75c3c0276ffbe3d52e127745124d3d4d6244a"
    sha256 cellar: :any,                 ventura:       "523e9929cfcee12a48f11af65f8cffa0801f037582666e920107287950ef66f6"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "01621ef1873af38c7e87b693d4f28e8db7dbe55116737f1876054c8fc4de7bf5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "45945d6d410ab48ef8a8c70caf4cf6def8138633bcd65d33a0882a5083501fe9"
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
