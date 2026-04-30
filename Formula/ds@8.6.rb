# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ds Extension
class DsAT86 < AbstractPhpExtension
  init
  desc "Ds PHP extension"
  homepage "https://github.com/php-ds/ext-ds"
  url "https://pecl.php.net/get/ds-2.0.0.tgz"
  sha256 "52dfed624fbca90ad9e426f7f91a0929db3575a1b8ff6ea0cf2606b7edbc3940"
  head "https://github.com/php-ds/ext-ds.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/ds/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "22626e53e14ba44253318c48c55f7866c829963b4dd82747d9c95f50ea5ada76"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "57fb5dd49dc7b1d14b37e99c836ceededdacaaa0fb79a30960b6a3091a93b4bc"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "6e1e5bb8896a1da7aa792ef8b55c1fd173f7d98fa49f2410872d24063c804b80"
    sha256 cellar: :any_skip_relocation, sonoma:        "8f851b984f74f0bf29538ab01790bb484a71dfc0c4263e206e01c88c908e447b"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "cea5a96d2aa286df9cfc1f59f708c69eeef536e30d56c7b7fa1a03cefa98ca57"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d617a36b93123ba4dd5bc2e596bab1223b3f90a9cfd6f9616a9c8847d3f4e6dd"
  end

  priority "30"

  def install
    Dir.chdir "ds-#{version}"
    Dir["src/php/**/*.{c,h}"].each do |f|
      next unless File.read(f).include?("XtOffsetOf")

      inreplace f do |s|
        s.gsub! "XtOffsetOf", "offsetof"
        s.sub!(/\A/, "#include <stddef.h>\n")
      end
    end
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-ds"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
