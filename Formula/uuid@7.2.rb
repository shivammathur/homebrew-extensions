# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Uuid Extension
class UuidAT72 < AbstractPhpExtension
  init
  desc "Uuid PHP extension"
  homepage "https://github.com/php/pecl-networking-uuid"
  url "https://pecl.php.net/get/uuid-1.2.1.tgz"
  sha256 "2235c8584ca8911ce5512ebf791e5bb1d849c323640ad3e0be507b00156481c7"
  head "https://github.com/php/pecl-networking-uuid.git", branch: "master"
  license "LGPL-2.1-only"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "79582f4e09cb0e929a88c048c3ace5ddca617f841f725d25cde2ad6ca8e56453"
    sha256 cellar: :any,                 arm64_sonoma:  "61e4aa014ba8e750352bba34ca677400d646808b4f5ae27b11424982ee1fa6b2"
    sha256 cellar: :any,                 arm64_ventura: "1d855be09c6ebac2377a535f43d877f2df7456770089781dec59a5cdf501e69c"
    sha256 cellar: :any,                 ventura:       "9b3892d4de56deadd17317c6fb439b9696acc20dbc587c053956b50395672300"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0c60fe696ca80cb0996fade2c02b68a116fe6691babc059efa8c4721a56a74f0"
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
