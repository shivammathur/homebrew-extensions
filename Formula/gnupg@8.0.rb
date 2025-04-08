# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gnupg Extension
class GnupgAT80 < AbstractPhpExtension
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
    rebuild 1
    sha256 cellar: :any,                 arm64_sequoia:  "24221001011431902f78f8a7cdbacd8da8c3c1f7bf22643706e0b7afd146b3a5"
    sha256 cellar: :any,                 arm64_ventura:  "edad34222ddbf846bc06730e77f66d4bfb0623c5006eab954c8f1768b6a146c6"
    sha256 cellar: :any,                 arm64_monterey: "366eac0c6016eaf71eaa7a56c733f0d6e9a20631e64e55277a5a4ecd4e9fdcf2"
    sha256 cellar: :any,                 arm64_big_sur:  "d83ee85604c574458d093808018f6037c542c8e34391efce86fb8060599ee159"
    sha256 cellar: :any,                 ventura:        "0b7bc11a575a3afedb4c7de06070648d0f57a7a71626dfeac067b38f1192c04c"
    sha256 cellar: :any,                 big_sur:        "8558480652263dae072654e0736f5eb82bb0600f08cafab775a9487a7612871c"
    sha256 cellar: :any,                 catalina:       "d4047aa913cef4425573c0afd1811c8d419565ece386fa816afeeb4002a0ebbb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "30980c313ecf9e7482cf8b6f28f50a4b56975c71e575d7636d60c2c77db51666"
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
