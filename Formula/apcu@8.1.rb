# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT81 < AbstractPhpExtension
  init
  desc "Apcu PHP extension"
  homepage "https://github.com/krakjoe/apcu"
  url "https://pecl.php.net/get/apcu-5.1.25.tgz"
  sha256 "c4e7bae1cc2b9f68857889c022c7ea8cbc38b830c07273a2226cc44dc6de3048"
  head "https://github.com/krakjoe/apcu.git"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/apcu/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "f97bd5a83b3c040ad33132f4d33fca0f3ad4b6ddcec5a17393eafc73dec3f54e"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "f832e3490271c874d0ab5db9d66c0618fe68ef5187f351db8ac1142468e4da72"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "d58a6cf0a7a8c4bbd15c9304dcf7d49a3015f4533c6fffeb42cafa4a6419354a"
    sha256 cellar: :any_skip_relocation, ventura:       "22e311886adcf52a2503ac17263cb833b3b80ffcd513d4edd743873346715828"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "60e09b42bd3d2c5c899425df0dea782229c567c58787026cd237e9c2728d2902"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "739b102fc5cd3c59b5159f021ec38cf37b08863f5e988fef81fdf4baf90d43de"
  end

  def install
    Dir.chdir "apcu-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-apcu"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
