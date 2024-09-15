# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Uuid Extension
class UuidAT81 < AbstractPhpExtension
  init
  desc "Uuid PHP extension"
  homepage "https://github.com/php/pecl-networking-uuid"
  url "https://pecl.php.net/get/uuid-1.2.0.tgz"
  sha256 "5cb834d32fa7d270494aa47fd96e062ef819df59d247788562695fd1f4e470a4"
  head "https://github.com/php/pecl-networking-uuid.git", branch: "master"
  license "LGPL-2.1-only"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia:  "b0d1eefacb47a7d683b482d45d9050af4d33084ea1e9e29080b1e8bc09879ed0"
    sha256 cellar: :any,                 arm64_ventura:  "52f7de388531ed1e9babbd192f7c1f434c925a34994b00f251ad8bfade6c3208"
    sha256 cellar: :any,                 arm64_monterey: "45b9d81bb03758a0ec2f2dd21b6e1896a89d25b492b152d1e6700f67dd7d1483"
    sha256 cellar: :any,                 arm64_big_sur:  "0814b656e9654e65c56e6a57f72176c40c569870f75ef6696275688a2b428d86"
    sha256 cellar: :any,                 ventura:        "26dd84ac441e6c97bd2e537d25ed6ddb0c730dca59d38294e5a039721586a560"
    sha256 cellar: :any,                 monterey:       "4b1a2b9b09dc1ee3e7e39143419b340727156ff15ace5d4e6e29bd5b04abe0fe"
    sha256 cellar: :any,                 big_sur:        "9e970f33f6a8404f0de18714ba08b7d8468eed79304b0ecb5c1ad2f3c7e8bbc2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "5740d1aba422e6c57cbd9ba79fc98222d75493564d63a4acd2faf59f3b328162"
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
