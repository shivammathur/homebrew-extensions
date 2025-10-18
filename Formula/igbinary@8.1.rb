# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT81 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.16.tar.gz"
  sha256 "941f1cf2ccbecdc1c221dbfae9213439d334be5d490a2f3da2be31e8a00b0cdb"
  head "https://github.com/igbinary/igbinary.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url :homepage
    strategy :git do |tags|
      semver_tags = tags.map(&:to_s).grep(/^v?\d+(\.\d+)+$/)
      semver_tags.max_by { |tag| Version.new(tag.delete_prefix("v")) }
    end
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:    "a1c4d95189af30c2eb465759d9c257f0a9e8cfaaa7591a90575c621b9001b7b4"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "b4edfef5401028205f1d80b10c16bb9d0d1b842819af7f5b11eef36b1f174f88"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "afa2bb892522e1dc369cdc0ef146374b570bd983b523de1d7746bb8addaf2084"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "47d11af9357c8dbe43fdde8befac7a36a91d1b4737cee4f83805f3858451f7e0"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "aa56af192f585bffcd78fd1cab02a18039ba09006c83369cd70e10ccb9a706e9"
    sha256 cellar: :any_skip_relocation, sonoma:         "2718737b74a503fa54a61213ca78017e268e3b0a36f3c300f32f821c111d2532"
    sha256 cellar: :any_skip_relocation, ventura:        "1cdaec5ea009f2018c245ac04ccc80f3d3b16c065c892f65993296d65e85062b"
    sha256 cellar: :any_skip_relocation, monterey:       "0ed9851f65a8ea8965f623a2205aca32bcceee78a6400eafc3da15cbfdcdf7ca"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "3ba05f2a97146e008ee4f389e75d807c72271d960f08369ee91c51bc0447d440"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "517d4e11d3ddd1a045d4a06598e37867462b8c9e56dc3dcb85df9ae76b223476"
  end

  def install
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-igbinary"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    Dir.chdir "src/php7"
    add_include_files
  end
end
