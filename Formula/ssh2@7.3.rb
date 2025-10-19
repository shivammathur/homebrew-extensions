# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ssh2 Extension
class Ssh2AT73 < AbstractPhpExtension
  init
  desc "Ssh2 PHP extension"
  homepage "https://github.com/php/pecl-networking-ssh2"
  url "https://pecl.php.net/get/ssh2-1.4.1.tgz"
  sha256 "7bca5b23f731db9d8ed0aea5db9bb15da8ff133b0fbba96102b82e95da4d8764"
  head "https://github.com/php/pecl-networking-ssh2.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/ssh2/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia:  "8bce49fa03643ecc411e198046a8c4a23aff75dcee414fab2a26cd1c34c7a40e"
    sha256 cellar: :any,                 arm64_sonoma:   "2c588a287e8967a0378ad0735b5e5c142e545d242d4e4e95717a190d8671c336"
    sha256 cellar: :any,                 arm64_ventura:  "21f69d5a5389ef1e04f95b0a02729718760bc8df5df52d5eb2c5b6b120cc1b67"
    sha256 cellar: :any,                 arm64_monterey: "bb6c255ac7951020c0545725ba721247ac3b20ee794fbf408ebfc8a8ec950792"
    sha256 cellar: :any,                 sonoma:         "b687794a4986b5ad3344a8ab52fde290861ad4f1640510f51292cc3396f30253"
    sha256 cellar: :any,                 ventura:        "40535022297db56388ca78a327be15a7784efcd17c64569d53429066e8944c77"
    sha256 cellar: :any,                 monterey:       "508f03909d37cd25eb29eaa8f577d58922c7cbf92fdbc406a21050f070a602f7"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "4114e81aaf597333c138a2bb8fc91d46543f970291818f3d28159436328a1ece"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "459dc6b0274292700857459aa39aa63407ab98d940ee8cc6c60036502b429a31"
  end

  depends_on "libssh2"

  def install
    args = %W[
      --with-ssh2=shared,#{Formula["libssh2"].opt_prefix}
    ]
    Dir.chdir "ssh2-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
