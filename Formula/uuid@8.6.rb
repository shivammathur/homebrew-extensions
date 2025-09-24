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
  head "https://github.com/php/pecl-networking-uuid.git", branch: "master"
  license "LGPL-2.1-only"

  livecheck do
    url "https://pecl.php.net/rest/r/uuid/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "99c02c13dd039d782b077b8726b66470fbf490d9ad3283561175db5e0bebd834"
    sha256 cellar: :any,                 arm64_sequoia: "78a7a371db7d53bee53afe9d6132eeeb046a247415e1724ac2846f3e42d2dc9a"
    sha256 cellar: :any,                 arm64_sonoma:  "a579b10a65268fd15fbdd56f34114136f0437a1261d9fc153e7276fe172246b6"
    sha256 cellar: :any,                 sonoma:        "c2f67ba1124d82b105b6825c0bad5d430043fe63bfb352fbf3bc11d0d71257a8"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "4cba3f162eecac754507c0cbc929aa2272ff80c112ccafda2d8e973cee86edbc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e2dd0ff6c24a4571369c0c5628162118b382e9ef0b8a819ae190fdee436497df"
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
