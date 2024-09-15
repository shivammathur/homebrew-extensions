# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Uuid Extension
class UuidAT72 < AbstractPhpExtension
  init
  desc "Uuid PHP extension"
  homepage "https://github.com/php/pecl-networking-uuid"
  url "https://pecl.php.net/get/uuid-1.2.0.tgz"
  sha256 "5cb834d32fa7d270494aa47fd96e062ef819df59d247788562695fd1f4e470a4"
  head "https://github.com/php/pecl-networking-uuid.git", branch: "master"
  license "LGPL-2.1-only"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia:  "cc9f7f60efdbf718455622618bd4d369474b8f8b640ff0bafe62de45193bb545"
    sha256 cellar: :any,                 arm64_ventura:  "36845944698b797f8ef1babc1fcf31b104b7bcb8307cfc5c9fa3cdd23a85acb0"
    sha256 cellar: :any,                 arm64_monterey: "0cbfbaad372a035fecff26643c86654a8de4a7eddcfe6691e1983c0b737f1c53"
    sha256 cellar: :any,                 arm64_big_sur:  "193297e3031c47bb990050044d932e3bde3aa8324bd29039304195a3ee0a2ff9"
    sha256 cellar: :any,                 ventura:        "72a6ff6c9f0b123fcce151f9911ac0d6269393ff1681e8efafe4208525f67ed0"
    sha256 cellar: :any,                 monterey:       "7c6bfa670a93b5bb1b3e1e140fb65c5efa11d87dbbe06270302cfe5bda609f90"
    sha256 cellar: :any,                 big_sur:        "f6fecbe91ae04355d6f8b124f580ae0cec58e46ff574a873805ad3e54a824540"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f1bdc59396f56e3f6ed465204317d931c312652abbb5052f8ca57373765b8766"
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
