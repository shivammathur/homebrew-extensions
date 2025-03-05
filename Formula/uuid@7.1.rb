# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Uuid Extension
class UuidAT71 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "57dff95bbe1a1a7bd6b826bca6b1aac55b9afc5ac00efc27e000ab50c7db951f"
    sha256 cellar: :any,                 arm64_sonoma:  "7ca3f05fc019861e5028f497cd958b32c2fecdc5c06bc4a2417cdaaefb1ca847"
    sha256 cellar: :any,                 arm64_ventura: "b929c6f7c27b468fc457732d559559dd1b630d32908ba8b6274fdb05501b9418"
    sha256 cellar: :any,                 ventura:       "03dec332049ff8f8a8a2ceeb75eae6f0b40126f06de1b5b22bdb0d2e40e7659a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "22b23a54189caae782e07da2b909c3ac6fc4a7bc2727835b861242a913b966f9"
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
