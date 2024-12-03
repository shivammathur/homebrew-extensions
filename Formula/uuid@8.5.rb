# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Uuid Extension
class UuidAT85 < AbstractPhpExtension
  init
  desc "Uuid PHP extension"
  homepage "https://github.com/php/pecl-networking-uuid"
  url "https://pecl.php.net/get/uuid-1.2.1.tgz"
  sha256 "2235c8584ca8911ce5512ebf791e5bb1d849c323640ad3e0be507b00156481c7"
  head "https://github.com/php/pecl-networking-uuid.git", branch: "master"
  license "LGPL-2.1-only"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "81c2ac9018e48b10a767addd368eea17a8ffd779e3d975e6d36ded74303eb54a"
    sha256 cellar: :any,                 arm64_sonoma:  "7d1bc4501f00056b80b7642d3c470b9209d084097a9f69d4c59130c67f94230c"
    sha256 cellar: :any,                 arm64_ventura: "6d55fc0b5251183edd75beeff2aa3ed31364091a90120f166ee9b1380968e05f"
    sha256 cellar: :any,                 ventura:       "c5f4333a12331afd3e0a481f7c106f2b505702f6d54736f71132cbfef1a16b9b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1d90441fa57e636d9b18aba50f1e6bdee396ca387afa72ed24b33dd778818f29"
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
