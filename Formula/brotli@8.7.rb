# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Brotli Extension
class BrotliAT87 < AbstractPhpExtension
  init
  desc "Brotli PHP extension"
  homepage "https://github.com/kjdev/php-ext-brotli"
  url "https://pecl.php.net/get/brotli-0.21.1.tgz"
  sha256 "33574094e39a433ede3570ba6fcf15d356fc3489abbda396f8cdac472338e1ce"
  revision 2
  head "https://github.com/kjdev/php-ext-brotli.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/brotli/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "eb272bbde8f9f9126aa31bfdc8504a9280377ed504f13909ac498ba913ee6f6b"
    sha256 cellar: :any, arm64_tahoe:       "74147ad491d1346fd6c4dffe02fd91925873d8e0d47b410bd33430dd97fde6d6"
    sha256 cellar: :any, arm64_sequoia:     "d42a5709bfd97fa7e23d6edf93d93c66b27b15a52f709c8565f54ae89c3571be"
    sha256 cellar: :any, arm64_linux:       "384f894d98099798453e1c13b414404f37b6a37cb27d8cd83e4eeb1bb8019422"
    sha256 cellar: :any, x86_64_linux:      "2716ac410f63d492308c1f05919250e118a826e908f581ee50c259c3cff10810"
  end

  depends_on "brotli"

  def install
    args = %W[
      --enable-brotli
      --with-libbrotli=#{Utils::Path.formula_opt_prefix("brotli")}
    ]
    Dir.chdir "brotli-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
