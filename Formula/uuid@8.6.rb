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
    sha256 cellar: :any,                 arm64_sequoia: "027f638a91fe36be1304b5affaadeff32cd0e4a1038d8404b2fc1b59acd5b376"
    sha256 cellar: :any,                 arm64_sonoma:  "171da75660ed8dc61e134aad266eb9f4ee68e8b383c075239ca328a4ad279d43"
    sha256 cellar: :any,                 arm64_ventura: "5651656428cca96007f5ea7abdfe4490001bb18e310fdcb44d80f7ce93e4ba3d"
    sha256 cellar: :any,                 ventura:       "370244277cab806be64397f5a5c9d6d5fcdbfa9bca55d953db84ed1c9618f227"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "692b8eb743fb56e3f1dad96edd65617ae8540b284a108a3623cf9c3879c03177"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a003625d61510146e144bbbf7f4b57b566ba2cb4f844b7cb30c18bff63952e64"
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
