# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Expect Extension
class ExpectAT84 < AbstractPhpExtension
  init
  desc "Expect PHP extension"
  homepage "https://github.com/sibaz/pecl-expect"
  url "https://pecl.php.net/get/expect-0.4.0.tgz"
  sha256 "032ff2f92a9f95a2cb91d9e1c1b711c696e562ea57cdec8459954d8b0601d442"
  head "https://github.com/sibaz/pecl-expect.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/expect/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 5
    sha256 cellar: :any,                 arm64_sequoia: "c47094a040c95294995d837e51ee2426f8cdd2bb8c22e734206c5486a2c155c1"
    sha256 cellar: :any,                 arm64_sonoma:  "7e202b68ee39420496d02dc7171394fdc75a30ef5ffdd502adc8165e2c7a57e3"
    sha256 cellar: :any,                 arm64_ventura: "5827900dc2d8ffeaee3efb563d622563a969e04d98508e0def1f780a37adad65"
    sha256 cellar: :any,                 ventura:       "a64991e7330d6e546dc46effeaa42cdf9cd0d86208b79fbc6abd717c2e76db0d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2161f1b22c8628eab3376db4795081ec6dd113e0f15308ebdabde9c03eac628f"
  end

  depends_on "expect"
  depends_on "tcl-tk@8"

  def add_expect_lib
    expect_lib = Dir["#{Formula["homebrew/core/expect"].opt_lib}/expect*/libexpect*"].first
    lib.install_symlink expect_lib => "libexpect#{File.extname(expect_lib)}" if expect_lib
    ENV.append "LDFLAGS", "-L#{lib}"
  end

  def add_expect_headers
    headers = Dir["#{Formula["tcl-tk@8"].opt_include}/**/*.h"]
    (buildpath/"expect-#{version}/include").install_symlink headers unless headers.empty?
    ENV.append "CFLAGS", "-I#{buildpath}/expect-#{version}/include"
  end

  def install
    args = %W[
      --with-expect=shared,#{Formula["expect"].opt_prefix}
      --with-tcldir=#{Formula["tcl-tk@8"].opt_prefix}/lib
    ]
    add_expect_lib
    add_expect_headers
    Dir.chdir "expect-#{version}"
    inreplace "expect_fopen_wrapper.c", " TSRMLS_DC", ""
    inreplace "expect.c" do |s|
      s.gsub! " TSRMLS_CC", ""
      s.gsub! "ulong", "zend_ulong"
    end
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
