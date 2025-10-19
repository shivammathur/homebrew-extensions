# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gnupg Extension
class GnupgAT80 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "9de4f505e667f629f8f9bd3899d61ead77c0989e3f176a8bf0722a31eee6330a"
    sha256 cellar: :any,                 arm64_sonoma:  "8f6df5c869be29fd788ca4fd7cae9a36bc74ec8192b9cf7914758b8815dcd3c5"
    sha256 cellar: :any,                 arm64_ventura: "252492500a541070119762917b9df7b960e64c8340d03ac6641ab3f8304da856"
    sha256 cellar: :any,                 sonoma:        "9844db8846f20b407e32445d257fc15288325b9861ac4ffb779cab7d51fc892f"
    sha256 cellar: :any,                 ventura:       "4204c74f528612924a0e854d67456f292e42f351c986594312ff32d9f481c16a"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "0c4aaff94e58ae0d28b7a00c01d962d2383f81fabec0e80d772d168f8d121831"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a5054404f87441718567183089a2f7c89a0e46afe8896a06fbfe0d18dfd3d46d"
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
