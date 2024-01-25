# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT72 < AbstractPhpExtension
  init
  desc "Event PHP extension"
  homepage "https://bitbucket.org/osmanov/pecl-event"
  url "https://pecl.php.net/get/event-3.1.2.tgz"
  sha256 "2de4f45ddea90da53fe0a811016e421b4d2e4d148d4ba2f90c19ac2494c23339"
  head "https://bitbucket.org/osmanov/pecl-event.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "4e9b58d09cbb5a44522462facd397052c87b3a53d461b3c32f7e68b390611c19"
    sha256 cellar: :any,                 arm64_ventura:  "75929bfd5e01adb82ab02ea0194ec49ba2f3e885b67f6c07c45bfc1d9c4a317f"
    sha256 cellar: :any,                 arm64_monterey: "8fa617ab2556e673890766b6227882dca851da7e717cb8e10f0b2cfe0fb5a317"
    sha256 cellar: :any,                 ventura:        "70311433abff18029a12dbcb669411010b5d5dbe7db945f79c4afb3a790b0a89"
    sha256 cellar: :any,                 monterey:       "5b155cce3459bf226c9b3ce52ddcd7730fb6377cb88fae7530ce7aa1b1e52dcc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "e5b4ba03e045fc59c3a5d711ad00fa236df4f71462e90950c5363946df24e102"
  end

  depends_on "libevent"
  depends_on "openssl@3"

  def install
    args = %W[
      --with-event-core
      --with-event-extra
      --with-event-openssl
      --enable-event-sockets
      --with-openssl-dir=#{Formula["openssl@3"].opt_prefix}
      --with-event-libevent-dir=#{Formula["libevent"].opt_prefix}
    ]
    Dir.chdir "event-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
