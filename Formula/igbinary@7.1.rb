# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT71 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:    "eb85092a3651e7cba84043bf14135c915df000d8277211f405884a4b5a5b4882"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "9504d1b752236caa6ee32072fcdebe7860266d11db4b2485b70ee84eba03f8ed"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "77240afb8e8149a3cd908bf2723d6917bdf37896d32b5be54dc208cb1d373e22"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "b2529a9f1535cf81039ec03dfb6524f2aa6e2efcdd968a951032b382e1744cd9"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "a0fdbe0bda4b1e0ff2472985d1104dca1e3da5ddba32c11fe52d3d137a1c9697"
    sha256 cellar: :any_skip_relocation, sonoma:         "a393138d9954434d9a5d66e4d003868f2f196b92e3f951b9aca8f9658ac5833e"
    sha256 cellar: :any_skip_relocation, ventura:        "de6f3b2d6790b70c068fdcc9b6bbd1a8c75d5d2bcaf6a09eea52b016a256e03c"
    sha256 cellar: :any_skip_relocation, monterey:       "5db1d66ae94c5ae462d7c07592f9e0eab06598879b27beadc6d2b4a51cdf8b88"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "dcb1a299f50d116142043dabc9cd85bd7837d8034dd097b08f68d37709ec0860"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "deafec63efb778b75b945a77f00cfdb4effec0da55491e61a6180293508d2665"
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
