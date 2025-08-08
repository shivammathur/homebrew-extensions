# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gnupg Extension
class GnupgAT81 < AbstractPhpExtension
  init
  desc "Gnupg PHP extension"
  homepage "https://github.com/php-gnupg/php-gnupg"
  url "https://pecl.php.net/get/gnupg-1.5.4.tgz"
  sha256 "4d4a0980759bf259e4129ef02cb592bbeb103b4005e7b4bb6945d79488951a50"
  head "https://github.com/php-gnupg/php-gnupg.git"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/gnupg/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "04db92c730a62f38e3e0a1c662131f68474fc8c154d183120ccb7c2b3dcda969"
    sha256 cellar: :any,                 arm64_sonoma:  "25d7c6961eab898d0f5ccea591ef2cc2e9fb15d70e83c78c8cb00e2223987e8f"
    sha256 cellar: :any,                 arm64_ventura: "8c216ffd86e7288129110698aa60894140407459b78ddf4da25c789c45bd2e66"
    sha256 cellar: :any,                 ventura:       "b7aea32317dd81aedffb8aefc5eccc2ec0a6d742020520d3243e7be9991580d0"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "2bff85681b846f2d53ada00c656b457ee2d58ba7c4e91808ed584d50262646cb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5da5d5c19577cf5180070d68681dcd4cdb7c8893a1d4a4949f256a63b6ea65ec"
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
