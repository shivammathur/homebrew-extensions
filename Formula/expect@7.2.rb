# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Expect Extension
class ExpectAT72 < AbstractPhpExtension
  init
  desc "Expect PHP extension"
  homepage "https://github.com/sibaz/pecl-expect"
  url "https://pecl.php.net/get/expect-0.4.0.tgz"
  sha256 "032ff2f92a9f95a2cb91d9e1c1b711c696e562ea57cdec8459954d8b0601d442"
  head "https://github.com/sibaz/pecl-expect.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_sequoia:  "84a04ac7f610f91ac24de2fbae2930a99425f1bbf4a9b59b565ed2eb346371d0"
    sha256 cellar: :any,                 arm64_ventura:  "bf31f5c2bc125c1ead24e838a91e5dfdfc2e2a1ddac467e4205f76cb90ab2df5"
    sha256 cellar: :any,                 arm64_monterey: "4815677fa12538c62faaf21749afecd3dcff37cbb369e2f475c08052d5dd8099"
    sha256 cellar: :any,                 arm64_big_sur:  "a73b058413e3da6e0e84c22fd1157fb937453832a7f057ce479141b69187030e"
    sha256 cellar: :any,                 ventura:        "11764bcc0e8f0a76ad6bd2f3f4ee3bc2c12ae625ef1790283ee841cb7964029c"
    sha256 cellar: :any,                 monterey:       "ec72f46961a05980dfeb1fe211485ccd4f75d7ace35d71876f6e2c938aebe061"
    sha256 cellar: :any,                 big_sur:        "8e126a8baf5a5978240ab0142fff08baa9b44a6ccdd193d597ea3a949fad296e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "713db1456bad5934ebe1f64d52bd0f1725126657c66f0fb2a88c9b026e2402dc"
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
  end

  def install
    args = %W[
      --with-expect=shared,#{Formula["expect"].opt_prefix}
      --with-tcldir=#{Formula["tcl-tk@8"].opt_prefix}/lib
    ]
    add_expect_lib
    add_expect_headers
    Dir.chdir "expect-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
