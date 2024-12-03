# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Uuid Extension
class UuidAT74 < AbstractPhpExtension
  init
  desc "Uuid PHP extension"
  homepage "https://github.com/php/pecl-networking-uuid"
  url "https://pecl.php.net/get/uuid-1.2.1.tgz"
  sha256 "2235c8584ca8911ce5512ebf791e5bb1d849c323640ad3e0be507b00156481c7"
  head "https://github.com/php/pecl-networking-uuid.git", branch: "master"
  license "LGPL-2.1-only"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia:  "5b4eb50f5634ecb3d1cd2e4d4aedb13df08442dc3b8e7d3a321a8acf413f5f49"
    sha256 cellar: :any,                 arm64_ventura:  "36aa22413f1283d2858be79caa2ee1d25e3fdc5b43bff59d1bde093d8576313f"
    sha256 cellar: :any,                 arm64_monterey: "83025b435d1592b3b679aa0a68ef65aceba7c648ec45dbb75db265dbd0bea2d3"
    sha256 cellar: :any,                 arm64_big_sur:  "230168896feb566bb6177f4780afaf746be153c8f98b0e6e26a302fc55ade3a7"
    sha256 cellar: :any,                 ventura:        "bfce0750f4276098f175af5c16aad7780671b5d8a6fb9281502d85b241d34cac"
    sha256 cellar: :any,                 monterey:       "e584bd9aefd60c7386689b2390da44bab754de43a51e731ecf6df5c6e9048c8b"
    sha256 cellar: :any,                 big_sur:        "39e9971a3642284a0cb60428dddd628249b0f2e20584418549e7a3c9b6319978"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "21d07e58b41e2be60090559975e88abe147806e6eed4ccf114b82d95721ee9ec"
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
