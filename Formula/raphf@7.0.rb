# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Raphf Extension
class RaphfAT70 < AbstractPhpExtension
  init
  desc "Raphf PHP extension"
  homepage "https://github.com/m6w6/ext-raphf"
  url "https://pecl.php.net/get/raphf-2.0.1.tgz"
  sha256 "da3566db17422e5ef08b7ff144162952aabc14cb22407cc6b1d2a2d095812bd0"
  head "https://github.com/m6w6/ext-raphf.git"
  license "BSD-2-Clause"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "a575a2b5f2a9637f4ffe6ec519b22107d9764880c9ec587d65dfd97a8222a43c"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "15ece18dd1f7ad4e4c739362b248daba8a910e3783f2ed4f325803e83bfaa7d7"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "31cb6695994a284fbc12541bf37a6c36c0b523a642ef5c5380c508fcd455d880"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "915a1b4ef10a7ebdd3ffc0927b62ded63665154335b78e8c10dc39f98cd185e8"
    sha256 cellar: :any_skip_relocation, ventura:        "74c8787a5dad2861ab6e6ae1495c862da0244668e52f95850f1e253d86498333"
    sha256 cellar: :any_skip_relocation, monterey:       "d44ada499d9e857a16f2fb3fa71e04ebd57125300f7584bd2b8d4a09100e519f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "3ac7e777117b85120d3feb9907cb411ad5fc8f8387229474bb8211781ec08c11"
  end

  def install
    Dir.chdir "raphf-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-raphf"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
