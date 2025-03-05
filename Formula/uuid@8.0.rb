# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Uuid Extension
class UuidAT80 < AbstractPhpExtension
  init
  desc "Uuid PHP extension"
  homepage "https://github.com/php/pecl-networking-uuid"
  url "https://pecl.php.net/get/uuid-1.2.1.tgz"
  sha256 "2235c8584ca8911ce5512ebf791e5bb1d849c323640ad3e0be507b00156481c7"
  head "https://github.com/php/pecl-networking-uuid.git", branch: "master"
  license "LGPL-2.1-only"

  livecheck do
    url "https://pecl.php.net/rest/r/uuid/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "9d36f140627fc69f22fddfc06d297f90479e36b78d58647a21f22f0b8437013e"
    sha256 cellar: :any,                 arm64_sonoma:  "d4455385ea1cc76f1957aa6164159a13cdb1071f9d76161062d5fb301ae66fc4"
    sha256 cellar: :any,                 arm64_ventura: "acacf711474cebc994939b17d73c5f1c29ced5bec947a595e5cac9319b7ee274"
    sha256 cellar: :any,                 ventura:       "0ffb6fc9edd62696ccbed93fe2bd6a9adee33554933b1e7110d1882c98f4b5d7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "21c0b2955cef5e4a602f5aea8a704adb6c296a93dbdc77ef31226c99da26af93"
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
