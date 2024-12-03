# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Uuid Extension
class UuidAT82 < AbstractPhpExtension
  init
  desc "Uuid PHP extension"
  homepage "https://github.com/php/pecl-networking-uuid"
  url "https://pecl.php.net/get/uuid-1.2.1.tgz"
  sha256 "2235c8584ca8911ce5512ebf791e5bb1d849c323640ad3e0be507b00156481c7"
  head "https://github.com/php/pecl-networking-uuid.git", branch: "master"
  license "LGPL-2.1-only"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia:  "2467dc1f78c47f79625347cada36e1bf07df4b376cefedc4f6d6d88679b795a8"
    sha256 cellar: :any,                 arm64_ventura:  "8b85830f92a9ad676039166383b06b166adf17a1a68ede82300c63d2576e72d6"
    sha256 cellar: :any,                 arm64_monterey: "4dd2167b1745e43bc18935c79d0c8f4bee9e4a4197502a1ab6339b09a69aff69"
    sha256 cellar: :any,                 arm64_big_sur:  "32ff8a6ad679b04027cf3630276f2634a056096c69a3878c98b7a57d333251d9"
    sha256 cellar: :any,                 ventura:        "3f775aa1f490c01062db17160f18b3f53f79d8a530c7ffa52a08f35a7561b289"
    sha256 cellar: :any,                 monterey:       "01ef4a2e38707965559be3fb14fa2029ab1bb23de2d9ce5c329c218b853416c3"
    sha256 cellar: :any,                 big_sur:        "cb6fb4a1c89366ed235243d43a75d4909421651f180e52b4f049822a18492259"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "7b34c853681d744d612556e702edc4742e400df261b4f242185a45ea28d90d6d"
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
