# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gnupg Extension
class GnupgAT70 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "410c9c4a4f7120f96ee14a5f54ff797426cd442597adb3153c2ea07630562939"
    sha256 cellar: :any,                 arm64_sonoma:  "24e620de6307d83191caef06b251095acbab1f99df812e50358b405bf3595076"
    sha256 cellar: :any,                 arm64_ventura: "444d6c956e135ead4b790e173fe8f486aedaf579f7b4c928fc3b87bb36c45b1d"
    sha256 cellar: :any,                 ventura:       "75a16a2a11d857082a9c20b9801d8a23536fbd885da3bb3490a6f8294204f3b7"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "66b2af6a51cb0368df2a94ab997936e8813a1f92322b6230e8ff126a94f60a96"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "74ff9b8344b44515a1267dbbb4e8291cc62e233d44bbccc49b9417178ec9d532"
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
