# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Uuid Extension
class UuidAT83 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "b2e5a0b3601ee4d6e2674d524bf950b9d85a436b39d6919969415a1b93af83c6"
    sha256 cellar: :any,                 arm64_sonoma:  "3c345b34b22a97b247ded5283a9976c4ff02099e5971685fab72e1554d51ff2d"
    sha256 cellar: :any,                 arm64_ventura: "559b2946d756ce469b1d2a93dd2421f0781d654d4606815c0aa61c8087549f31"
    sha256 cellar: :any,                 sonoma:        "b5b681df4e849e0bac7f0a8259019a46579b12a8422709fd19f63b37384f7082"
    sha256 cellar: :any,                 ventura:       "14937d275e4b18e2cc79ad50f67f28bab93097d9fe64fe56d373ecfe17a0727d"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "df42efd73857d1bd0db1e1cc77f6e8f0521fe4d6baa8c51415ab7fb744ff24f4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3baa865eb74ccd62b0411b1b0dcb74223cdf4d2cea90bec22342b83db0fbfe97"
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
