# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gnupg Extension
class GnupgAT81 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "de5ee605ce97d6efb91708a071be3a5c5836d76ed0ad25b659fd5c3657b5b022"
    sha256 cellar: :any,                 arm64_sonoma:  "f6b6c4e5da366abf57fd953d0f4258b0ddabd2614534a74fe2562f6f8db5a4d3"
    sha256 cellar: :any,                 arm64_ventura: "0b53b0857a99829aefd7cb5535edaec55be0bb120490b4ca4524530532c4ca23"
    sha256 cellar: :any,                 ventura:       "5e2599c56636e48c52a61a3f2b7a667ad4f2771e9a92e5aea905e361636a892d"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "a6b45016fe8c32473ed37eb7395e44ca6a98103fed433a4f19b399f6c60b9d94"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a1275cba5c967f14035dcb24987b95a6e317551c591ade845005bebb131f2f13"
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
