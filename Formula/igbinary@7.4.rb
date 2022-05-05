# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT74 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.7.tar.gz"
  sha256 "21863908348f90a8a895c8e92e0ec83c9cf9faffcfd70118b06fe2dca30eaa96"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_monterey: "3ad5ca37e62ccc6ec2ebd2957edc998d4bb851574c82c3b7feed4be57d2583de"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "11873234522d259a71140dba6fb1132c9cca82719baa414e995ffdfb996c8faf"
    sha256 cellar: :any_skip_relocation, monterey:       "1410b9a05d521df1781462e6dcd00bce4b9d8c793ab81efd8a3cd406e3c629af"
    sha256 cellar: :any_skip_relocation, big_sur:        "a9a303dc169cb15fc18a6d350d1a8e53ae35c6a15ce2d68209a69a00d7c93914"
    sha256 cellar: :any_skip_relocation, catalina:       "8aa8e549c1f7f33c2ca1a5a172595e368500f273f9c9a415cf7eb99c60ae1340"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "05546ff969a7bf853a9a66dcb49254d0115209873ead8aa561fc45b9ed15092f"
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
