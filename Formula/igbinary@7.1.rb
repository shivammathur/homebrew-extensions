# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT71 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.7.tar.gz"
  sha256 "21863908348f90a8a895c8e92e0ec83c9cf9faffcfd70118b06fe2dca30eaa96"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "ed38582901f54acfa835a4fd468239067969eaba145ecb0a865a4a674b4eba9e"
    sha256 cellar: :any_skip_relocation, big_sur:       "225e6636da74a190acbc79fc533f249e86c368b21e174ed3d4ad99f210d6c659"
    sha256 cellar: :any_skip_relocation, catalina:      "2d0b74bfb57df8897daa942a79ade9ed8937b64c2c5400a994fc30f3355b48ec"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8d2507299029c26737ce9d7b414ef5d21932cf015cfde9095e7f5246cc1abe19"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-igbinary"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    Dir.chdir "src/php7"
    add_include_files
  end
end
