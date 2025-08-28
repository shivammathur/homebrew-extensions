# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT82 < AbstractPhpExtension
  init
  desc "Apcu PHP extension"
  homepage "https://github.com/krakjoe/apcu"
  url "https://pecl.php.net/get/apcu-5.1.26.tgz"
  sha256 "aed8d359d98c33723b65e4ba58e5422e5cf794c54fbd2241be31f83a49b44dde"
  head "https://github.com/krakjoe/apcu.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/apcu/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "bc0dd9c1fa7200d871ece8ebbf17d41cd19f83681a4aa968750bdc6fc4137f08"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "2a27640915b0abffad99d4589980544edf069873a4467171d6f81db3be120512"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "0f947380ae819b01cbb9e834e7aba4d2aa58085ff44e00deec34ac40fadd4aeb"
    sha256 cellar: :any_skip_relocation, ventura:       "ae1948c3776897f689923e53397469e2c2a227935a6a94139a2de76bb78f9b63"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "ac6e00c79fce581aa20c36f700fdcfdb56d0458bf38c54a090a3c38ee0ced840"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7da9cda3c5f99f2a42935094ff1b20339fc8b8461c84959a682646730d939824"
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
