# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Uuid Extension
class UuidAT83 < AbstractPhpExtension
  init
  desc "Uuid PHP extension"
  homepage "https://github.com/php/pecl-networking-uuid"
  url "https://pecl.php.net/get/uuid-1.2.0.tgz"
  sha256 "5cb834d32fa7d270494aa47fd96e062ef819df59d247788562695fd1f4e470a4"
  head "https://github.com/php/pecl-networking-uuid.git", branch: "master"
  license "LGPL-2.1-only"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "a27f0679509cbc281c5db41bddc0bf126ce72645cbc88cd9f71e0586e499fbf3"
    sha256 cellar: :any,                 arm64_big_sur:  "df7a0dfb7d973242551adae780f5ce252ad33f704f2b58931a412c58064ba935"
    sha256 cellar: :any,                 ventura:        "183144ecaf76570c68fa6190a17a9a09d1b8b5f7dea47eb1601088364fbabba7"
    sha256 cellar: :any,                 monterey:       "966c8ad1284833825b55be701a78d97036240824ac0b48eedcbdbb8b5156c90e"
    sha256 cellar: :any,                 big_sur:        "d59fb3a898a19db33d43477e04c745984607796ee3960b5f065e4bcdc4ba7f8c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "464540e7ff1b91b29fab201b21fec3851ac691a2fc873178344e8fa1e73b8edf"
  end

  def uuid_dependency
    if OS.linux?
      "util-linux"
    else
      "e2fsprogs"
    end
  end

  on_macos do
    depends_on "e2fsprogs"
  end

  on_linux do
    depends_on "util-linux"
  end

  def install
    args = %W[
      --with-uuid=#{Formula[uuid_dependency].opt_prefix}
    ]
    Dir.chdir "uuid-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
