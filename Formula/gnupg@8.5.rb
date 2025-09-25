# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gnupg Extension
class GnupgAT85 < AbstractPhpExtension
  init
  desc "Gnupg PHP extension"
  homepage "https://github.com/php-gnupg/php-gnupg"
  url "https://pecl.php.net/get/gnupg-1.5.4.tgz"
  sha256 "4d4a0980759bf259e4129ef02cb592bbeb103b4005e7b4bb6945d79488951a50"
  revision 1
  head "https://github.com/php-gnupg/php-gnupg.git", branch: "master"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/gnupg/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "ba405f650b2f79c0387bf16aba156c11ee3a3094e4194902a7ec2bb6f328415e"
    sha256 cellar: :any,                 arm64_sequoia: "5c81a5b532edb1fd03c45e21e4ce0915a366cfc673d856bc523d4489931317eb"
    sha256 cellar: :any,                 arm64_sonoma:  "8517d35113f60d4994bba0df671876f0890ad9c0520542a83720264612d9be90"
    sha256 cellar: :any,                 sonoma:        "03ada1ceb8c781a577a6583ad62f5e4c0439f031f5e15225152c9ad8ebd8af33"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "c18a77114d62582058aeb43b97f043cf2b6f9d13c7bad3790a6b713edc3178ef"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "16c01aa5b3b7a6a70a0ebba88c02e37a449155c0fd344f8e373443db0a9567ef"
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
