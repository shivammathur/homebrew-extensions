# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Uuid Extension
class UuidAT82 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "261b277a8b8e391a7890e3d845138281c9f9de7d69e3b67041159cb50dd546ae"
    sha256 cellar: :any,                 arm64_sonoma:  "f12465703df378c17d09e890e2c39c3b2d46e5c0c04c7fbafcd2135fb5b4976a"
    sha256 cellar: :any,                 arm64_ventura: "43bb1a07a2bbf2ec48afa87a3101ff7332899962e8b28033eb343b87fe6b049e"
    sha256 cellar: :any,                 ventura:       "0b53e205e7562e2c4befb937c49d2c2d79fb9f769592309c7cbd5445528498d7"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "129df997157dd9725a9f31995b8ecb98fa8b28805f952441992d1ea7f494b4c3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "45a8de1b47bd86c4a1ed7d6a17869f7acf334148a00b9e6a89239621fb5cfcd8"
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
