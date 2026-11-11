# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Uuid Extension
class UuidAT86 < AbstractPhpExtension
  init
  desc "Uuid PHP extension"
  homepage "https://github.com/php/pecl-networking-uuid"
  url "https://pecl.php.net/get/uuid-1.3.0.tgz"
  sha256 "b7af055e2c409622f8c5e6242d1c526c00e011a93c39b10ca28040b908da3f37"
  revision 2
  head "https://github.com/php/pecl-networking-uuid.git", branch: "master"
  license "LGPL-2.1-only"

  livecheck do
    url "https://pecl.php.net/rest/r/uuid/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "e8d31fd73e99c5e62cc143ad5b9a49ca9a2eaf13f223f43ce11291f0365097bf"
    sha256 cellar: :any, arm64_tahoe:       "d0655b72566ace9564802d7d4d702705a69d6673d8b5373a411685b318fb2ef2"
    sha256 cellar: :any, arm64_sequoia:     "2303001af13347b3a1ddadaae99fd1678055d2f1ae5cf8ac06c61f1a91ce595b"
    sha256 cellar: :any, arm64_linux:       "128f43c1801cd39795a7d72fc167b0ab794314f4f975f9dea2d7a039b9937325"
    sha256 cellar: :any, x86_64_linux:      "e5893bd87e354c71e86b7d1ae107b46ac0af89a7b3ced4d90cb1d0bea00a448d"
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
      --with-uuid=#{Utils::Path.formula_opt_prefix(uuid_dependency)}
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
