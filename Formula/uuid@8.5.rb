# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Uuid Extension
class UuidAT85 < AbstractPhpExtension
  init
  desc "Uuid PHP extension"
  homepage "https://github.com/php/pecl-networking-uuid"
  url "https://pecl.php.net/get/uuid-1.3.0.tgz"
  sha256 "b7af055e2c409622f8c5e6242d1c526c00e011a93c39b10ca28040b908da3f37"
  revision 1
  head "https://github.com/php/pecl-networking-uuid.git", branch: "master"
  license "LGPL-2.1-only"

  livecheck do
    url "https://pecl.php.net/rest/r/uuid/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "d27562d24fec993c677de9af90ccd7b13504b088d7365a569563f562203836ea"
    sha256 cellar: :any,                 arm64_sequoia: "bc9e854b53256b42fcb7f0e7cb8fb239757cebb12eccfe24b7a44b82037105f9"
    sha256 cellar: :any,                 arm64_sonoma:  "e6b587126efcdc1252c1d8abe65a6da35eed76e49db3226141d3d3fb857631de"
    sha256 cellar: :any,                 sonoma:        "a8d1536c60f3d1f4372a79d6a3bc41465735719f122f6ea260abd85f6ea1b30b"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "9a2a49800b9b6e304b776e5570ab04a96f71ea8fa6ecc4534eff12e3d516fee1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d6f5d84100e9cb8ba923573b8751fb8ff07d4f131c0d8afa7d55f3f93efb16f4"
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
