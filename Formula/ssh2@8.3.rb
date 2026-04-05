# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ssh2 Extension
class Ssh2AT83 < AbstractPhpExtension
  init
  desc "Ssh2 PHP extension"
  homepage "https://github.com/php/pecl-networking-ssh2"
  url "https://pecl.php.net/get/ssh2-1.5.0.tgz"
  sha256 "a943427fae39a5503c813179018ae6c500323c8c9fb434e1a9a665fb32a4d7b4"
  head "https://github.com/php/pecl-networking-ssh2.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/ssh2/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "bf40402de3be30b2d2019363851bfedeab5384dc247a23745bb3939dcfaa0b6d"
    sha256 cellar: :any,                 arm64_sequoia: "824ba5f0ce4a854af68bc448c28d10146c11bcc5017dd21de3603ea2eb3bec45"
    sha256 cellar: :any,                 arm64_sonoma:  "451ce285a6169a6da4ab227f8302bdc6043d5e0c244b5e95bb821d7f2edffb58"
    sha256 cellar: :any,                 sonoma:        "2c9d07a8abc9abae8a8fe9d2432f23b0fd4a8ceea315d1afd3bba1ee31dfab53"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "ffcedbc8287b50079c961e4ae6e695fedb5d0d996d00dd007b9a061592a3210f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "25b03433263c8153eba5b44540aafb42a5973e109a1132a8f3b91b9c416cac11"
  end

  depends_on "libssh2"

  def install
    args = %W[
      --with-ssh2=shared,#{Formula["libssh2"].opt_prefix}
    ]
    Dir.chdir "ssh2-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
