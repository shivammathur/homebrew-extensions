# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT72 < AbstractPhpExtension
  init
  desc "Apcu PHP extension"
  homepage "https://github.com/krakjoe/apcu"
  url "https://pecl.php.net/get/apcu-5.1.26.tgz"
  sha256 "aed8d359d98c33723b65e4ba58e5422e5cf794c54fbd2241be31f83a49b44dde"
  head "https://github.com/krakjoe/apcu.git"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/apcu/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "8f8a8cd410c51aedaf1aa786af21154c763a46b0746fef6ca780c299b45c2cc2"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "b246d96cd368f9bac4e690a66355f0dc01e9f9c5d6d51e08fca3808d8fab1778"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "012732c418bd4cd5c922a6d1de0efca9250dd7715d17f3f5807d1eeb3eaab6bc"
    sha256 cellar: :any_skip_relocation, ventura:       "52afca02d6ec2423cb304c285999c8d694169df88508bc31347c60d5f3bd2a99"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "ceb33a6814384ee77ee52481c8f0d8770bcb45852f8a3d0372c166b18ba16ee2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "01a75f688784f0acccaea4449bbe7769f08b9ba9f21a7518a5d2a499c5946ad5"
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
