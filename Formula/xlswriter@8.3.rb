# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT83 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-2.0.3.tgz"
  sha256 "b69c168780527ec73fa3d7986d4279ecce00e184760f6572cc5e450a68b4f201"
  head "https://github.com/viest/php-ext-xlswriter.git", branch: "master"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/xlswriter/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "d43d0543b00fe6dec053258d7f6d8e6a3a10bf8341efe70d63b9cd923dbaeb33"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "1ecc37e34da4104493aa0d9a85a92255ab1e0bce3d7c675c44252ee43b7a07b2"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "cc30982943b133de5771608c0ebb7e9d706660766c2a156eed4a5b9e86515b45"
    sha256 cellar: :any_skip_relocation, sonoma:        "206da380dddf81502fc4ffcfc1bd631a546cf3b839c83448cfa76b4738344af5"
    sha256 cellar: :any,                 arm64_linux:   "ffffd74acdbd4b426c276c0744835d94053401df26e79372fa8351f4d743f286"
    sha256 cellar: :any,                 x86_64_linux:  "74f0c85d6bbdd97c9c26ef8e28369d409637e3dc7d9ccea40ade8d54b0c5c72c"
  end

  def install
    args = %w[
      --with-xlswriter
      --enable-reader
    ]
    Dir.chdir "xlswriter-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
