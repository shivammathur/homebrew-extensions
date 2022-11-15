# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Propro Extension
class ProproAT72 < AbstractPhpExtension
  init
  desc "Propro PHP extension"
  homepage "https://github.com/m6w6/ext-propro"
  url "https://pecl.php.net/get/propro-2.1.0.tgz"
  sha256 "7bba0653d90cd8f61816e13ac6c0f7102b4a16dc4c4e966095a121eeb4ae8271"
  head "https://github.com/m6w6/ext-propro.git"
  license "BSD-2-Clause"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_monterey: "54d7775290a67c39ddb20df1b4a001be2bd5df376a131c36749b96341e45c8c1"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "ef878175013d73dd82be74196ad3bbbfce583d1095cc7c01671033efc7bd0027"
    sha256 cellar: :any_skip_relocation, monterey:       "3ef68b99ece93a17dd7191017546a07bb7597844da2267885dce20c3b964bd7d"
    sha256 cellar: :any_skip_relocation, big_sur:        "cc30c98b22d661c670cf55cfcdf051800aa1290936e9bc8c1f22fb99dc367c1d"
    sha256 cellar: :any_skip_relocation, catalina:       "53d95b07b3e2143d557788dd530a44203ca9b98be63a52cb85487d63c0ded62e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "37a590b5840c40f3b9c6806018b439a7794c47c7dd42c0e3c41e2ee2bbf024c0"
  end

  def install
    Dir.chdir "propro-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-propro"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
