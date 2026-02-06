# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Uopz Extension
class UopzAT72 < AbstractPhpExtension
  init
  desc "Uopz PHP extension"
  homepage "https://github.com/krakjoe/uopz"
  url "https://pecl.php.net/get/uopz-6.1.2.tgz"
  sha256 "d84b8a2ed89afc174be2dd2771410029deaf5796a2473162f94681885a4d39a8"
  head "https://github.com/krakjoe/uopz.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/uopz/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "834a880a1f29de6086ceb76a057d604aa5903487addb84731c8763b0224d1de1"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "fe3d13a2156cdff90bfbc8becad4e243dfbcaa320ff7ab1d3a5c14c816eb92ae"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "c6922b86e836f88b94f753de1449851d0e8fd27715a2c8dc39a26aefac481f6b"
    sha256 cellar: :any_skip_relocation, sonoma:        "4cb3c8fb53f7231e2edccdf9cacc499467444634ac918509b888918d8036800a"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "20cb172dc3d6307c0974be07eead4bfd37b2c6971a5088889e8bcc2d8d7ce798"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8626ce9179fccd6f9759f7e5b3ecb76b17a735e3c04d612d263a9601572c1f23"
  end

  def install
    Dir.chdir "uopz-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-uopz"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
